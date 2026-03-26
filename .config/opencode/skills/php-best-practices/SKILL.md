---
name: php-best-practices
description: Modern PHP 8.x patterns, strict typing, PSR standards, SOLID principles, and error handling. Use when writing or reviewing PHP code, ensuring type safety, following PSR standards, or applying design patterns.
---

# PHP Best Practices

Modern PHP 8.x patterns, strict typing, PSR standards, and SOLID principles.

## When to Use

- Writing or reviewing PHP code
- Implementing classes and interfaces
- Ensuring type safety and modern PHP usage
- Following PSR standards
- Applying SOLID principles

## Strict Types

Always declare strict types at the top of every PHP file:

```php
<?php

declare(strict_types=1);
```

## Type Everything

### Parameters and Return Types

```php
public function calculateTotal(array $items, float $taxRate): float
{
    // ...
}

public function findUser(int $id): ?User
{
    // ...
}

public function delete(int $id): void
{
    // ...
}
```

### Typed Properties

```php
final class OrderService
{
    private readonly OrderRepository $repository;
    private float $discount = 0.0;
}
```

### Union and Intersection Types

```php
public function process(string|int $id): void { }

public function handle(Countable&Iterator $collection): void { }
```

## Modern PHP Features

### Constructor Property Promotion

```php
final class CreateOrderAction
{
    public function __construct(
        private readonly OrderRepository $orders,
        private readonly NotificationService $notifications,
    ) {}
}
```

### Readonly Properties and Classes

```php
final readonly class Money
{
    public function __construct(
        public int $amount,
        public string $currency,
    ) {}
}
```

### Enums

```php
enum OrderStatus: string
{
    case Pending = 'pending';
    case Processing = 'processing';
    case Completed = 'completed';
    case Cancelled = 'cancelled';

    public function label(): string
    {
        return match ($this) {
            self::Pending => 'Pending',
            self::Processing => 'Processing',
            self::Completed => 'Completed',
            self::Cancelled => 'Cancelled',
        };
    }

    public function canTransitionTo(self $status): bool
    {
        return match ($this) {
            self::Pending => in_array($status, [self::Processing, self::Cancelled]),
            self::Processing => in_array($status, [self::Completed, self::Cancelled]),
            default => false,
        };
    }
}
```

### Match Expression

```php
// Prefer match over switch
$result = match ($status) {
    'pending' => $this->handlePending(),
    'active', 'processing' => $this->handleActive(),
    default => throw new InvalidArgumentException("Unknown status: {$status}"),
};
```

### Nullsafe Operator

```php
$country = $user?->getAddress()?->getCountry()?->getCode();
```

### Named Arguments

```php
$user = User::create(
    name: $dto->name,
    email: $dto->email,
    role: Role::Member,
);
```

### Arrow Functions

```php
$names = array_map(fn(User $user) => $user->name, $users);
$adults = array_filter($users, fn(User $user) => $user->age >= 18);
```

### First-Class Callable Syntax

```php
$names = array_map($this->formatName(...), $users);
```

## SOLID Principles

### Single Responsibility

Each class should have one reason to change.

```php
// Bad: Controller does validation, business logic, and formatting
// Good: Split into FormRequest, Action/Service, and Resource

final class CreateOrderAction
{
    public function handle(CreateOrderDto $data): Order
    {
        // Only responsible for creating orders
    }
}
```

### Dependency Inversion

Depend on abstractions, not concretions.

```php
interface PaymentGateway
{
    public function charge(Money $amount, string $token): PaymentResult;
}

final class StripeGateway implements PaymentGateway
{
    public function charge(Money $amount, string $token): PaymentResult
    {
        // Stripe-specific implementation
    }
}

final class OrderService
{
    public function __construct(
        private readonly PaymentGateway $gateway, // Depends on interface
    ) {}
}
```

### Interface Segregation

Small, focused interfaces over large ones.

```php
// Bad
interface Repository
{
    public function find(int $id): ?Model;
    public function create(array $data): Model;
    public function update(int $id, array $data): Model;
    public function delete(int $id): void;
    public function export(): string;
    public function import(string $data): void;
}

// Good
interface ReadableRepository
{
    public function find(int $id): ?Model;
}

interface WritableRepository
{
    public function create(array $data): Model;
    public function update(int $id, array $data): Model;
    public function delete(int $id): void;
}
```

## Error Handling

### Custom Exceptions

```php
final class OrderNotFoundException extends RuntimeException
{
    public static function withId(int $id): self
    {
        return new self("Order with ID {$id} not found.");
    }
}

// Usage
throw OrderNotFoundException::withId($orderId);
```

### Catch Specific Exceptions

```php
try {
    $result = $gateway->charge($amount, $token);
} catch (InsufficientFundsException $e) {
    return $this->handleInsufficientFunds($e);
} catch (GatewayTimeoutException $e) {
    return $this->retryOrFail($e);
}

// Never suppress errors with @
```

## PSR Standards

- **PSR-4**: Autoloading — one class per file, namespace matches directory
- **PSR-12**: Coding style — `final class`, braces on new lines for classes/methods, same line for control structures
- Use `declare(strict_types=1)` in every file
- Use `final` on classes by default — only remove when inheritance is explicitly needed

## Value Objects and DTOs

```php
final readonly class CreateOrderDto
{
    public function __construct(
        public int $customerId,
        public array $items,
        public ?string $notes = null,
    ) {}

    public static function from(array $validated): self
    {
        return new self(
            customerId: $validated['customer_id'],
            items: $validated['items'],
            notes: $validated['notes'] ?? null,
        );
    }
}
```

## Performance Tips

- Use native array functions (`array_map`, `array_filter`) over manual loops
- Use generators for large datasets: `yield` instead of building arrays
- Prefer `===` over `==` for comparisons
- Avoid global state and static methods when possible

## Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Class | PascalCase | `OrderService` |
| Method | camelCase | `calculateTotal()` |
| Variable | camelCase | `$orderTotal` |
| Constant | UPPER_SNAKE | `MAX_RETRY_COUNT` |
| Interface | PascalCase | `PaymentGateway` |
| Enum | PascalCase | `OrderStatus` |
| Trait | PascalCase | `HasFactory` |
