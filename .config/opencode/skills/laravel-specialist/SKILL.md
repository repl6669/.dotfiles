---
name: laravel-specialist
description: Senior Laravel specialist guidance for building Laravel 10+ applications. Use when implementing Eloquent models, creating APIs with resources, setting up queues and jobs, building Livewire components, implementing Sanctum authentication, or optimizing database performance.
---

# Laravel Specialist

Senior Laravel specialist with deep expertise in Laravel 10+, Eloquent ORM, and modern PHP 8.2+ development.

## When to Use

- Building Laravel 10+ applications
- Implementing Eloquent models and relationships
- Creating RESTful APIs with API resources
- Setting up queue systems and jobs
- Implementing authentication with Sanctum
- Optimizing database queries and performance

## Core Workflow

1. **Analyze requirements** — Identify models, relationships, APIs, queue needs
2. **Design architecture** — Plan database schema, service layers, job queues
3. **Implement models** — Create Eloquent models with relationships, scopes, casts
4. **Build features** — Develop controllers, services, API resources, jobs
5. **Test thoroughly** — Write feature and unit tests with >85% coverage

## Output Template

When implementing a Laravel feature, provide:

1. Migration file (database schema with indexes)
2. Model file (Eloquent model with relationships, casts, scopes)
3. Form Request (validation rules)
4. Service/Action class (business logic)
5. Controller (thin, delegates to service/action)
6. API Resource (response transformation)
7. Policy (authorization)
8. Test file (feature/unit tests)

## Constraints

### MUST DO

- Use PHP 8.2+ features (readonly, enums, typed properties, constructor promotion)
- Type hint all method parameters and return types
- Use `declare(strict_types=1)` in every file
- Use Eloquent relationships properly (eager load, avoid N+1)
- Implement API resources for transforming responses
- Queue long-running tasks (reports, exports, emails, webhooks)
- Write comprehensive tests (>85% coverage)
- Use service container and dependency injection
- Follow PSR-12 coding standards
- Use Form Requests for all validation
- Use policies/gates for all authorization
- Wrap multi-step mutations in DB transactions

### MUST NOT DO

- Use raw queries without parameter binding (SQL injection risk)
- Skip eager loading (causes N+1 problems)
- Store sensitive data unencrypted
- Mix business logic in controllers (keep them thin)
- Hardcode configuration values (use `config()` and `.env`)
- Skip validation on user input
- Use deprecated Laravel features
- Ignore queue failures (implement `failed()` method on jobs)
- Use `protected $guarded = []` on models
- Return Eloquent models directly from controllers (use Resources)

## Eloquent Patterns

### Model Configuration

```php
<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletes;

final class Project extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = ['name', 'slug', 'owner_id', 'status'];

    protected $casts = [
        'status' => ProjectStatus::class,
        'archived_at' => 'datetime',
    ];

    public function owner(): BelongsTo
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function tasks(): HasMany
    {
        return $this->hasMany(Task::class);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->whereNull('archived_at');
    }
}
```

### Eager Loading

```php
// Prevent N+1 — always eager load
$projects = Project::with(['owner', 'tasks'])->get();

// Nested
$projects = Project::with(['owner.profile', 'tasks.assignee'])->get();

// Constrained
$projects = Project::with([
    'tasks' => fn ($query) => $query->where('status', 'open')->latest(),
])->get();

// Prevent lazy loading in development
Model::preventLazyLoading(!app()->isProduction());
```

## API Patterns

### Resource Controller

```php
final class ProjectController extends Controller
{
    public function __construct(
        private readonly CreateProjectAction $createProject,
    ) {}

    public function index(Request $request): JsonResponse
    {
        $projects = Project::query()
            ->where('owner_id', $request->user()->id)
            ->with('tasks')
            ->withCount('tasks')
            ->latest()
            ->paginate(25);

        return response()->json([
            'success' => true,
            'data' => ProjectResource::collection($projects->items()),
            'meta' => [
                'page' => $projects->currentPage(),
                'per_page' => $projects->perPage(),
                'total' => $projects->total(),
            ],
        ]);
    }

    public function store(StoreProjectRequest $request): JsonResponse
    {
        $project = $this->createProject->handle($request->toDto());

        return response()->json([
            'success' => true,
            'data' => ProjectResource::make($project),
        ], 201);
    }
}
```

### API Resource

```php
final class ProjectResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'slug' => $this->slug,
            'status' => $this->status,
            'owner' => UserResource::make($this->whenLoaded('owner')),
            'tasks_count' => $this->whenCounted('tasks'),
            'created_at' => $this->created_at->toIso8601String(),
            'updated_at' => $this->updated_at->toIso8601String(),
        ];
    }
}
```

## Queue Patterns

### Job with Retry and Backoff

```php
final class GenerateReportJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;
    public array $backoff = [10, 60, 300];

    public function __construct(
        private readonly Report $report,
    ) {}

    public function handle(ReportService $service): void
    {
        $service->generate($this->report);
    }

    public function failed(Throwable $exception): void
    {
        Log::error('Report generation failed', [
            'report_id' => $this->report->id,
            'error' => $exception->getMessage(),
        ]);
    }
}

// Dispatch
GenerateReportJob::dispatch($report)->onQueue('reports');
```

## Auth with Sanctum

```php
// Routes
Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('projects', ProjectController::class);
    Route::get('/me', fn (Request $request) => $request->user());
});

// Testing
use Laravel\Sanctum\Sanctum;

Sanctum::actingAs($user, ['*']);
$this->getJson('/api/projects')->assertOk();
```

## Testing Pattern

```php
uses(RefreshDatabase::class);

test('owner can create project', function () {
    $user = User::factory()->create();

    actingAs($user)
        ->postJson('/api/projects', ['name' => 'My Project'])
        ->assertCreated()
        ->assertJsonPath('data.name', 'My Project');

    assertDatabaseHas('projects', [
        'name' => 'My Project',
        'owner_id' => $user->id,
    ]);
});

test('unauthenticated user cannot access projects', function () {
    $this->getJson('/api/projects')->assertUnauthorized();
});
```

## Reference Topics

| Topic | When to Consult |
|-------|----------------|
| Eloquent ORM | Models, relationships, scopes, query optimization |
| Routing & APIs | Routes, controllers, middleware, API resources |
| Queue System | Jobs, workers, Horizon, failed jobs, batching |
| Testing | Feature tests, factories, mocking, Pest |
| Security | Auth, validation, rate limiting, encryption |
| Validation | Form requests, custom rules, conditional rules |
