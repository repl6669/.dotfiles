---
name: eloquent-best-practices
description: Best practices for Laravel Eloquent ORM including query optimization, N+1 prevention, relationship management, mass assignment, casts, scopes, and chunking. Use when working with models, relationships, database queries, or optimizing Eloquent performance.
---

# Eloquent Best Practices

## When to Use

- Creating or modifying Eloquent models
- Writing database queries
- Optimizing query performance
- Defining relationships, scopes, or casts
- Reviewing code for N+1 issues

## Always Eager Load Relationships

```php
// N+1 Problem
$posts = Post::all();
foreach ($posts as $post) {
    echo $post->user->name; // N additional queries
}

// Eager Loading
$posts = Post::with('user')->get();

// Nested eager loading
$posts = Post::with(['author.profile', 'comments.user', 'tags'])->get();

// Constrained eager loading
$posts = Post::with([
    'comments' => fn ($query) => $query->latest()->limit(5),
])->get();
```

### Prevent Lazy Loading in Development

```php
// In AppServiceProvider::boot()
Model::preventLazyLoading(!app()->isProduction());
```

## Select Only Needed Columns

```php
// Only needed columns
$users = User::select(['id', 'name', 'email'])->get();

// With relationships
$posts = Post::with(['user:id,name'])->select(['id', 'title', 'user_id'])->get();
```

## Query Scopes

```php
final class Post extends Model
{
    public function scopePublished(Builder $query): Builder
    {
        return $query->where('status', 'published')
                    ->whereNotNull('published_at');
    }

    public function scopePopular(Builder $query, int $threshold = 100): Builder
    {
        return $query->where('views', '>', $threshold);
    }
}

// Usage
$posts = Post::published()->popular()->get();
```

## Relationships with Return Types

```php
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

final class Post extends Model
{
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function comments(): HasMany
    {
        return $this->hasMany(Comment::class);
    }

    public function tags(): BelongsToMany
    {
        return $this->belongsToMany(Tag::class)->withTimestamps();
    }
}
```

## Use withCount for Counts

```php
// Efficient
$posts = Post::withCount('comments')->get();
// Access: $post->comments_count

// Multiple counts
$users = User::withCount(['posts', 'comments'])->get();
```

## Mass Assignment Protection

```php
final class Post extends Model
{
    // Whitelist fillable attributes
    protected $fillable = ['title', 'content', 'status'];

    // NEVER do this
    // protected $guarded = [];
}
```

## Casts for Type Safety

```php
protected $casts = [
    'published_at' => 'datetime',
    'metadata' => 'array',
    'is_featured' => 'boolean',
    'views' => 'integer',
    'status' => PostStatus::class,         // Enum cast
    'api_token' => 'encrypted',            // Encrypted at rest
    'settings' => AsCollection::class,     // Collection cast
];
```

## Chunking for Large Datasets

```php
// Process in chunks to save memory
Post::chunk(200, function ($posts) {
    foreach ($posts as $post) {
        // Process each post
    }
});

// Lazy collections (one at a time)
Post::lazy()->each(function ($post) {
    // Process
});

// Chunked by ID (safe for updates)
Post::chunkById(200, function ($posts) {
    $posts->each->archive();
});
```

## Database-Level Operations

```php
// Bulk update (single query)
Post::where('status', 'draft')->update(['status' => 'archived']);

// Increment/decrement
Post::where('id', $id)->increment('views');

// Upsert
Post::upsert(
    [['slug' => 'foo', 'title' => 'Foo'], ['slug' => 'bar', 'title' => 'Bar']],
    ['slug'],       // unique columns
    ['title']       // columns to update on conflict
);
```

Prefer database-level operations over loading models into memory when you don't need model events.

## Model Events

```php
final class Post extends Model
{
    protected static function booted(): void
    {
        static::creating(function (Post $post) {
            $post->slug = Str::slug($post->title);
        });

        static::deleting(function (Post $post) {
            $post->comments()->delete();
        });
    }
}
```

Use sparingly — prefer explicit service/action methods for complex side effects.

## Don't Query in Loops

```php
// Bad
foreach ($userIds as $id) {
    $user = User::find($id);
}

// Good
$users = User::whereIn('id', $userIds)->get()->keyBy('id');
```

## Always Add Indexes

```php
Schema::create('posts', function (Blueprint $table) {
    $table->id();
    $table->foreignId('user_id')->constrained()->index();
    $table->string('slug')->unique();
    $table->string('status')->index();
    $table->timestamp('published_at')->nullable()->index();

    // Composite index for common queries
    $table->index(['status', 'published_at']);
});
```

## Transactions for Multi-Step Writes

```php
DB::transaction(function () use ($order) {
    $order->update(['status' => 'paid']);
    $order->items()->update(['paid_at' => now()]);
});
```

## Soft Deletes

```php
use Illuminate\Database\Eloquent\SoftDeletes;

final class Project extends Model
{
    use SoftDeletes;
}

// Query including soft deleted
Project::withTrashed()->find($id);

// Restore
$project->restore();

// Force delete
$project->forceDelete();
```

## Checklist

- [ ] Relationships eagerly loaded where needed
- [ ] Only selecting required columns
- [ ] Using query scopes for reusable filters
- [ ] Mass assignment protection configured
- [ ] Appropriate casts defined
- [ ] Indexes on foreign keys and query columns
- [ ] Database-level operations used when possible
- [ ] Chunking for large datasets
- [ ] Lazy loading prevented in development
- [ ] No queries inside loops
