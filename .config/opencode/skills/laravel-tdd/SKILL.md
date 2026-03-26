---
name: laravel-tdd
description: Test-driven development for Laravel with Pest and PHPUnit. Use when writing tests, creating feature/unit tests, testing endpoints, using factories, fakes, or when the user mentions TDD, testing, Pest, or PHPUnit.
---

# Laravel TDD Workflow

Test-driven development for Laravel applications using Pest (preferred) and PHPUnit with 80%+ coverage.

## When to Use

- Writing tests for new features or endpoints
- Bug fixes or refactors that need test coverage
- Testing Eloquent models, policies, jobs, notifications
- User mentions "test", "TDD", "Pest", "PHPUnit", or "coverage"
- Prefer Pest for new tests unless the project already standardizes on PHPUnit

## Red-Green-Refactor Cycle

1. Write a failing test
2. Implement the minimal change to pass
3. Refactor while keeping tests green

## Test Layers

| Layer | Use For | Trait |
|-------|---------|-------|
| **Unit** | Pure PHP classes, value objects, services | None needed |
| **Feature** | HTTP endpoints, auth, validation, policies | `RefreshDatabase` |
| **Integration** | Database + queue + external boundaries | `RefreshDatabase` |

## Database Strategy

- `RefreshDatabase` — default for most tests touching the DB. Runs migrations once, wraps each test in a transaction.
- `DatabaseTransactions` — when schema is already migrated and you only need per-test rollback.
- `DatabaseMigrations` — when you need a full `migrate:fresh` for every test (expensive).

## Pest Examples

### Basic Feature Test

```php
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\assertDatabaseHas;

uses(RefreshDatabase::class);

test('owner can create project', function () {
    $user = User::factory()->create();

    $response = actingAs($user)->postJson('/api/projects', [
        'name' => 'New Project',
    ]);

    $response->assertCreated();
    assertDatabaseHas('projects', ['name' => 'New Project']);
});
```

### Testing Paginated Index

```php
use App\Models\Project;
use App\Models\User;

use function Pest\Laravel\actingAs;

uses(RefreshDatabase::class);

test('projects index returns paginated results', function () {
    $user = User::factory()->create();
    Project::factory()->count(3)->for($user)->create();

    $response = actingAs($user)->getJson('/api/projects');

    $response->assertOk();
    $response->assertJsonStructure(['data', 'meta']);
});
```

### Testing Validation

```php
use App\Models\User;

use function Pest\Laravel\actingAs;

uses(RefreshDatabase::class);

test('creating a project requires a name', function () {
    $user = User::factory()->create();

    actingAs($user)
        ->postJson('/api/projects', [])
        ->assertUnprocessable()
        ->assertJsonValidationErrors(['name']);
});
```

### Testing Authorization

```php
use App\Models\Project;
use App\Models\User;

use function Pest\Laravel\actingAs;

uses(RefreshDatabase::class);

test('non-owner cannot update project', function () {
    $project = Project::factory()->create();
    $otherUser = User::factory()->create();

    actingAs($otherUser)
        ->putJson("/api/projects/{$project->id}", ['name' => 'Hacked'])
        ->assertForbidden();
});
```

## PHPUnit Examples

### Feature Test

```php
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

final class ProjectControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_owner_can_create_project(): void
    {
        $user = User::factory()->create();

        $response = $this->actingAs($user)->postJson('/api/projects', [
            'name' => 'New Project',
        ]);

        $response->assertCreated();
        $this->assertDatabaseHas('projects', ['name' => 'New Project']);
    }
}
```

## Factories and States

- Use factories for all test data
- Define states for edge cases (archived, admin, trial)
- Never hardcode IDs or timestamps

```php
$admin = User::factory()->state(['role' => 'admin'])->create();
$archived = Project::factory()->archived()->create();
```

## Fakes for Side Effects

```php
// Jobs
Bus::fake();
dispatch(new SendOrderConfirmation($order->id));
Bus::assertDispatched(SendOrderConfirmation::class);

// Queue
Queue::fake();
dispatch(new ProcessReport($report));
Queue::assertPushed(ProcessReport::class);

// Mail
Mail::fake();
Mail::to($user)->send(new WelcomeMail($user));
Mail::assertSent(WelcomeMail::class);

// Notifications
Notification::fake();
$user->notify(new InvoiceReady($invoice));
Notification::assertSentTo($user, InvoiceReady::class);

// Events
Event::fake();
event(new OrderPlaced($order));
Event::assertDispatched(OrderPlaced::class);

// HTTP
Http::fake([
    'api.example.com/*' => Http::response(['status' => 'ok'], 200),
]);
Http::assertSent(fn ($request) => $request->url() === 'https://api.example.com/check');
```

## Auth Testing with Sanctum

```php
use Laravel\Sanctum\Sanctum;

Sanctum::actingAs($user, ['*']);

$response = $this->getJson('/api/projects');
$response->assertOk();
```

## Assertions Cheat Sheet

```php
// HTTP response
$response->assertOk();              // 200
$response->assertCreated();         // 201
$response->assertNoContent();       // 204
$response->assertUnprocessable();   // 422
$response->assertForbidden();       // 403
$response->assertNotFound();        // 404

// JSON
$response->assertJson(['key' => 'value']);
$response->assertJsonStructure(['data' => ['id', 'name']]);
$response->assertJsonCount(3, 'data');
$response->assertJsonMissing(['secret' => 'value']);
$response->assertJsonValidationErrors(['field']);

// Database
$this->assertDatabaseHas('table', ['column' => 'value']);
$this->assertDatabaseMissing('table', ['column' => 'value']);
$this->assertDatabaseCount('table', 5);
$this->assertSoftDeleted('table', ['id' => 1]);

// Models
$this->assertModelExists($model);
$this->assertModelMissing($model);
```

## Coverage

- Target 80%+ coverage for unit + feature tests
- Use `pcov` or `XDEBUG_MODE=coverage` in CI
- Run: `php artisan test --coverage --min=80`

## Test Commands

```bash
php artisan test                          # Run all tests
php artisan test --filter=ProjectTest     # Filter by name
php artisan test tests/Feature/           # Run a directory
vendor/bin/pest                           # Run Pest directly
vendor/bin/pest --parallel                # Parallel execution
```

## Test Configuration

Use `phpunit.xml` to set test-specific database:

```xml
<env name="DB_CONNECTION" value="sqlite"/>
<env name="DB_DATABASE" value=":memory:"/>
```
