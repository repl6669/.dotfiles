---
name: laravel-security
description: Laravel security best practices for authentication, authorization, validation, CSRF, mass assignment, file uploads, secrets, rate limiting, and secure deployment. Use when adding auth, handling user input, building API endpoints, managing secrets, or hardening production.
---

# Laravel Security Best Practices

Comprehensive security guidance for Laravel applications.

## When to Use

- Adding authentication or authorization
- Handling user input and file uploads
- Building new API endpoints
- Managing secrets and environment settings
- Hardening production deployments
- Reviewing code for security issues

## Core Security Settings

- `APP_DEBUG=false` in production
- `APP_KEY` must be set and rotated on compromise
- `SESSION_SECURE_COOKIE=true` and `SESSION_SAME_SITE=lax` (or `strict` for sensitive apps)
- `SESSION_HTTP_ONLY=true` to prevent JavaScript access
- Configure trusted proxies for correct HTTPS detection
- Regenerate sessions on login and privilege changes

## Authentication

### API Auth with Sanctum

```php
Route::middleware('auth:sanctum')->get('/me', function (Request $request) {
    return $request->user();
});
```

- Use Sanctum or Passport for API auth
- Prefer short-lived tokens with refresh flows
- Revoke tokens on logout and compromise

### Password Security

```php
use Illuminate\Validation\Rules\Password;

$validated = $request->validate([
    'password' => [
        'required', 'confirmed',
        Password::min(12)->letters()->mixedCase()->numbers()->symbols(),
    ],
]);

$user->update(['password' => Hash::make($validated['password'])]);
```

- Always use `Hash::make()` — never store plaintext
- Use Laravel's password broker for reset flows

## Authorization

### Policies

```php
// In controller
$this->authorize('update', $project);

// As route middleware
Route::put('/projects/{project}', [ProjectController::class, 'update'])
    ->middleware(['auth:sanctum', 'can:update,project']);
```

- Use policies for model-level authorization
- Enforce authorization in every controller action
- Never rely on client-side checks alone

## Input Validation

- Always validate with Form Requests — never trust raw input
- Use strict rules and type checks
- Never trust request payloads for derived fields (user_id, roles, etc.)

## Mass Assignment Protection

```php
// Always define $fillable
protected $fillable = ['name', 'email', 'status'];

// NEVER do this
// protected $guarded = [];
```

- Use `$fillable` or `$guarded` on every model
- Never use `Model::unguard()` outside seeders
- Prefer DTOs or explicit attribute mapping

## SQL Injection Prevention

```php
// Always use parameter binding
DB::select('select * from users where email = ?', [$email]);

// Use Eloquent/query builder — they bind automatically
User::where('email', $email)->first();
```

- Avoid `DB::raw()` with user input
- If raw SQL is necessary, always use `?` parameter binding

## XSS Prevention

- Blade `{{ }}` escapes output by default — always use it
- Only use `{!! !!}` for trusted, sanitized HTML
- Sanitize rich text with a dedicated library (e.g., HTMLPurifier)

## CSRF Protection

- Keep `VerifyCsrfToken` middleware enabled
- Include `@csrf` in all forms
- For SPAs: configure Sanctum stateful domains and send XSRF tokens

```php
// config/sanctum.php
'stateful' => explode(',', env('SANCTUM_STATEFUL_DOMAINS', 'localhost')),
```

## File Upload Safety

```php
final class UploadInvoiceRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'invoice' => ['required', 'file', 'mimes:pdf', 'max:5120'],
        ];
    }
}

// Store outside public path
$path = $request->file('invoice')->store('invoices', 'local');
```

- Validate file size, MIME type, and extension
- Store uploads outside the public directory
- Generate random filenames — never use user-supplied names

## Rate Limiting

```php
use Illuminate\Cache\RateLimiting\Limit;

RateLimiter::for('login', function (Request $request) {
    return [
        Limit::perMinute(5)->by($request->ip()),
        Limit::perMinute(5)->by(Str::lower($request->input('email'))),
    ];
});
```

- Apply `throttle` middleware on auth, write, and sensitive endpoints
- Use stricter limits for login, password reset, and OTP

## Encrypted Attributes

```php
protected $casts = [
    'api_token' => 'encrypted',
    'ssn' => 'encrypted',
];
```

Use encrypted casts for sensitive columns stored at rest.

## Security Headers

```php
final class SecurityHeaders
{
    public function handle(Request $request, Closure $next): Response
    {
        $response = $next($request);

        $response->headers->add([
            'Content-Security-Policy' => "default-src 'self'",
            'Strict-Transport-Security' => 'max-age=31536000',
            'X-Frame-Options' => 'DENY',
            'X-Content-Type-Options' => 'nosniff',
            'Referrer-Policy' => 'no-referrer',
        ]);

        return $response;
    }
}
```

## CORS

```php
// config/cors.php
return [
    'paths' => ['api/*', 'sanctum/csrf-cookie'],
    'allowed_origins' => ['https://app.example.com'], // Never use wildcard for auth routes
    'supports_credentials' => true,
];
```

## Secrets and Credentials

- Never commit secrets to source control
- Use `.env` and secret managers
- Rotate keys after any exposure
- Add `.env` to `.gitignore`

## Logging and PII

```php
Log::info('User updated profile', [
    'user_id' => $user->id,
    'email' => '[REDACTED]',
]);
```

- Never log passwords, tokens, or full card data
- Redact sensitive fields in structured logs
- Ensure detailed exceptions are not returned in API responses

## Signed URLs

```php
$url = URL::temporarySignedRoute(
    'downloads.invoice',
    now()->addMinutes(15),
    ['invoice' => $invoice->id]
);

Route::get('/invoices/{invoice}/download', [InvoiceController::class, 'download'])
    ->name('downloads.invoice')
    ->middleware('signed');
```

## Dependency Security

- Run `composer audit` regularly
- Pin dependencies and update promptly on CVEs
- Review third-party packages before adoption

## Checklist

- [ ] `APP_DEBUG=false` in production
- [ ] All routes have appropriate auth middleware
- [ ] All mutations have authorization checks (policies/gates)
- [ ] All user input validated via Form Requests
- [ ] Mass assignment protection on all models
- [ ] No raw SQL with unbound user input
- [ ] Rate limiting on auth and sensitive endpoints
- [ ] Sensitive data encrypted at rest
- [ ] No secrets in source control
- [ ] No PII in logs
- [ ] CORS restricted to known origins
- [ ] Security headers configured
- [ ] `composer audit` clean
