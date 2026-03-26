---
name: laravel-patterns
description: Laravel architecture patterns for controllers, services, actions, Eloquent models, migrations, API resources, queues, events, and caching. Use when structuring Laravel applications, creating controllers, services, models, migrations, or building APIs.
---

# Laravel Development Patterns

Production-grade architecture patterns for scalable, maintainable Laravel applications.

## When to Use

- Structuring a new feature or module
- Creating controllers, services, or action classes
- Working with Eloquent models and relationships
- Designing APIs with resources and pagination
- Adding queues, events, caching, or background jobs
- Writing migrations

## Project Structure

```
app/
├── Actions/            # Single-purpose use cases
├── Console/
├── Events/
├── Exceptions/
├── Http/
│   ├── Controllers/
│   ├── Middleware/
│   ├── Requests/       # Form request validation
│   └── Resources/      # API resources
├── Jobs/
├── Models/
├── Policies/
├── Providers/
├── Services/           # Coordinating domain services
└── Support/
config/
database/
├── factories/
├── migrations/
└── seeders/
routes/
├── api.php
├── web.php
└── console.php
```

## Controllers → Services → Actions

Keep controllers thin. Put orchestration in services and single-purpose logic in actions.

### Action Class

```php
final class CreateOrderAction
{
    public function __construct(private OrderRepository $orders) {}

    public function handle(CreateOrderData $data): Order
    {
        return $this->orders->create($data);
    }
}
```

### Thin Controller

```php
final class OrdersController extends Controller
{
    public function __construct(private CreateOrderAction $createOrder) {}

    public function store(StoreOrderRequest $request): JsonResponse
    {
        $order = $this->createOrder->handle($request->toDto());

        return response()->json([
            'success' => true,
            'data' => OrderResource::make($order),
        ], 201);
    }
}
```

### Service Class (for orchestration)

```php
final class PostService
{
    public function __construct(
        private readonly NotificationService $notifications,
    ) {}

    public function publish(Post $post): Post
    {
        return DB::transaction(function () use ($post) {
            $post->update([
                'published_at' => now(),
                'status' => 'published',
            ]);

            event(new PostPublished($post));
            $this->notifications->notifyFollowers($post->author, $post);

            return $post->fresh();
        });
    }
}
```

## Routing

### Resource Routes with Middleware

```php
Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('projects', ProjectController::class);
});
```

### Scoped Bindings (prevent cross-tenant access)

```php
Route::scopeBindings()->group(function () {
    Route::get('/accounts/{account}/projects/{project}', [ProjectController::class, 'show']);
});
```

### Policy Middleware

```php
Route::put('/projects/{project}', [ProjectController::class, 'update'])
    ->middleware(['auth:sanctum', 'can:update,project']);
```

## Eloquent Models

### Model Configuration

```php
final class Project extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = ['name', 'owner_id', 'status'];

    protected $casts = [
        'status' => ProjectStatus::class,
        'archived_at' => 'datetime',
    ];

    // Relationships with return types
    public function owner(): BelongsTo
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function tasks(): HasMany
    {
        return $this->hasMany(Task::class);
    }

    // Scopes
    public function scopeActive(Builder $query): Builder
    {
        return $query->whereNull('archived_at');
    }

    public function scopeOwnedBy(Builder $query, int $userId): Builder
    {
        return $query->where('owner_id', $userId);
    }
}
```

### Eager Loading

```php
// Always eager load to prevent N+1
$posts = Post::with(['author', 'category', 'tags'])->get();

// Nested
$posts = Post::with(['author.profile', 'comments.user'])->get();

// Constrained
$posts = Post::with([
    'comments' => fn ($query) => $query->latest()->limit(5),
])->get();

// Prevent lazy loading in dev
Model::preventLazyLoading(!app()->isProduction());
```

### Efficient Counts

```php
$posts = Post::withCount('comments')->get();
// Access: $post->comments_count
```

## Migrations

```php
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('customer_id')->constrained()->cascadeOnDelete();
            $table->string('status', 32)->index();
            $table->unsignedInteger('total_cents');
            $table->timestamps();
            $table->softDeletes();

            // Composite index for common queries
            $table->index(['customer_id', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
```

Key rules:
- Always add indexes on foreign keys and frequently queried columns
- Use `constrained()->cascadeOnDelete()` for foreign keys
- Use `softDeletes()` for recoverable records
- Timestamp columns are `snake_case`

## API Resources

```php
final class ProjectResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'status' => $this->status,
            'owner' => UserResource::make($this->whenLoaded('owner')),
            'tasks_count' => $this->whenCounted('tasks'),
            'created_at' => $this->created_at->toIso8601String(),
        ];
    }
}
```

### Consistent Paginated Response

```php
$projects = Project::query()->active()->paginate(25);

return response()->json([
    'success' => true,
    'data' => ProjectResource::collection($projects->items()),
    'meta' => [
        'page' => $projects->currentPage(),
        'per_page' => $projects->perPage(),
        'total' => $projects->total(),
    ],
]);
```

## Events and Jobs

- Emit domain events for side effects (emails, analytics, audit logs)
- Use queued jobs for slow work (reports, exports, webhooks)
- Prefer idempotent handlers with retries and backoff

```php
// Dispatch event
event(new OrderPlaced($order));

// Queued job
dispatch(new GenerateInvoicePdf($order))->onQueue('reports');
```

## Transactions

Wrap multi-step mutations in transactions:

```php
DB::transaction(function () use ($order) {
    $order->update(['status' => 'paid']);
    $order->items()->update(['paid_at' => now()]);
    event(new OrderPaid($order));
});
```

## Caching

- Cache read-heavy endpoints and expensive queries
- Invalidate caches on model events (created/updated/deleted)
- Use tags when caching related data

```php
$projects = Cache::tags(['projects', "user:{$userId}"])
    ->remember("user:{$userId}:projects", 3600, function () use ($userId) {
        return Project::where('owner_id', $userId)->with('tasks')->get();
    });
```

## Service Container Bindings

```php
final class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->bind(OrderRepository::class, EloquentOrderRepository::class);
    }
}
```

## Checklist for New Features

1. Create migration with proper indexes
2. Create Eloquent model with fillable, casts, relationships, scopes
3. Create Form Request with validation rules
4. Create Action or Service class for business logic
5. Create thin controller
6. Create API Resource for response transformation
7. Create Policy for authorization
8. Write feature tests
