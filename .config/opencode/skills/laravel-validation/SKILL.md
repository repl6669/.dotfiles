---
name: laravel-validation
description: Form request validation and comprehensive validation testing for Laravel. Use when working with validation rules, form requests, custom rules, conditional validation, or validation testing.
---

# Laravel Validation

Form requests as single source of truth for validation, with comprehensive testing patterns.

## When to Use

- Creating or modifying form request classes
- Adding validation rules to endpoints
- Writing tests for validation logic
- Implementing custom validation rules
- Working with conditional or nested array validation

## Core Principle

All validation lives in Form Request classes. Never validate inline in controllers.

## Form Request Pattern

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

final class StoreOrderRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()?->can('create', Order::class) ?? false;
    }

    public function rules(): array
    {
        return [
            'customer_id' => ['required', 'integer', 'exists:customers,id'],
            'items' => ['required', 'array', 'min:1'],
            'items.*.product_id' => ['required', 'integer', 'exists:products,id'],
            'items.*.quantity' => ['required', 'integer', 'min:1'],
            'notes' => ['nullable', 'string', 'max:1000'],
        ];
    }

    public function messages(): array
    {
        return [
            'items.min' => 'At least one item is required.',
            'items.*.quantity.min' => 'Each item must have a quantity of at least 1.',
        ];
    }

    public function toDto(): CreateOrderDto
    {
        return CreateOrderDto::from($this->validated());
    }
}
```

## Common Validation Rules

### Strings
```php
'name' => ['required', 'string', 'min:2', 'max:255'],
'slug' => ['required', 'string', 'alpha_dash', 'max:255', 'unique:posts,slug'],
'email' => ['required', 'string', 'email:rfc,dns', 'max:255'],
'url' => ['required', 'url:https'],
```

### Numbers
```php
'price' => ['required', 'numeric', 'min:0', 'decimal:0,2'],
'quantity' => ['required', 'integer', 'min:1', 'max:1000'],
'percentage' => ['required', 'numeric', 'between:0,100'],
```

### Dates
```php
'starts_at' => ['required', 'date', 'after:now'],
'ends_at' => ['required', 'date', 'after:starts_at'],
'birth_date' => ['required', 'date', 'before:today'],
```

### Files
```php
'avatar' => ['required', 'image', 'mimes:jpg,png,webp', 'max:2048'],
'document' => ['required', 'file', 'mimes:pdf,docx', 'max:10240'],
```

### Relationships
```php
'category_id' => ['required', 'exists:categories,id'],
'tags' => ['nullable', 'array'],
'tags.*' => ['exists:tags,id'],
```

### Passwords
```php
use Illuminate\Validation\Rules\Password;

'password' => ['required', 'confirmed', Password::min(12)->letters()->mixedCase()->numbers()->symbols()],
```

### Enums
```php
use Illuminate\Validation\Rules\Enum;

'status' => ['required', new Enum(OrderStatus::class)],
```

## Conditional Validation

```php
public function rules(): array
{
    return [
        'type' => ['required', 'in:individual,company'],
        'company_name' => ['required_if:type,company', 'string', 'max:255'],
        'vat_number' => ['required_if:type,company', 'string'],
        'first_name' => ['required_if:type,individual', 'string', 'max:255'],
    ];
}
```

### Using `sometimes` and `after` hooks

```php
public function rules(): array
{
    return [
        'coupon_code' => ['sometimes', 'string', 'exists:coupons,code'],
    ];
}

public function after(): array
{
    return [
        function (Validator $validator) {
            if ($this->coupon_code && !$this->isCouponValid($this->coupon_code)) {
                $validator->errors()->add('coupon_code', 'This coupon has expired.');
            }
        },
    ];
}
```

## Nested Array Validation

```php
public function rules(): array
{
    return [
        'addresses' => ['required', 'array', 'min:1', 'max:5'],
        'addresses.*.street' => ['required', 'string', 'max:255'],
        'addresses.*.city' => ['required', 'string', 'max:255'],
        'addresses.*.zip' => ['required', 'string', 'regex:/^\d{5}$/'],
        'addresses.*.country' => ['required', 'string', 'size:2'],
        'addresses.*.is_primary' => ['boolean'],
    ];
}
```

## Custom Validation Rules

```php
<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

final class NoDisposableEmail implements ValidationRule
{
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $domain = substr(strrchr($value, '@'), 1);

        if (in_array($domain, config('mail.disposable_domains', []))) {
            $fail('Disposable email addresses are not allowed.');
        }
    }
}

// Usage
'email' => ['required', 'email', new NoDisposableEmail],
```

## Testing Validation (Pest)

### Test required fields

```php
uses(RefreshDatabase::class);

test('name is required to create a project', function () {
    $user = User::factory()->create();

    actingAs($user)
        ->postJson('/api/projects', [])
        ->assertUnprocessable()
        ->assertJsonValidationErrors(['name']);
});
```

### Test max length

```php
test('name cannot exceed 255 characters', function () {
    $user = User::factory()->create();

    actingAs($user)
        ->postJson('/api/projects', ['name' => str_repeat('a', 256)])
        ->assertUnprocessable()
        ->assertJsonValidationErrors(['name']);
});
```

### Test valid data passes

```php
test('valid data creates a project', function () {
    $user = User::factory()->create();

    actingAs($user)
        ->postJson('/api/projects', ['name' => 'My Project'])
        ->assertCreated();
});
```

### Dataset-driven validation tests

```php
dataset('invalid_project_data', [
    'missing name' => [[], ['name']],
    'name too long' => [['name' => str_repeat('a', 256)], ['name']],
    'name not a string' => [['name' => 123], ['name']],
    'invalid status' => [['name' => 'Ok', 'status' => 'bogus'], ['status']],
]);

test('rejects invalid project data', function (array $data, array $errors) {
    $user = User::factory()->create();

    actingAs($user)
        ->postJson('/api/projects', $data)
        ->assertUnprocessable()
        ->assertJsonValidationErrors($errors);
})->with('invalid_project_data');
```

## Prepare Input

Use `prepareForValidation` to normalize input before rules run:

```php
protected function prepareForValidation(): void
{
    $this->merge([
        'slug' => Str::slug($this->name),
        'email' => Str::lower($this->email),
    ]);
}
```

## DTO Transformation

Always extract validated data into a DTO for type safety in your service layer:

```php
public function toDto(): CreateOrderDto
{
    $validated = $this->validated();

    return new CreateOrderDto(
        customerId: (int) $validated['customer_id'],
        items: $validated['items'],
        notes: $validated['notes'] ?? null,
    );
}
```
