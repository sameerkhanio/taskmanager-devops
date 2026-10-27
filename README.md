# Task Manager (Django, dark theme)

Signup/login, tasks (CRUD, filters, search), a Kanban board, notes linked to tasks, and a dashboard with status counts.
Each user only ever sees their own data.

## Run locally (Windows / Mac / Linux)

```bash
python -m venv venv
venv\Scripts\activate          # Mac/Linux: source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

Open http://127.0.0.1:8000 and create an account. Locally it uses SQLite, so no PostgreSQL is needed.
(A "No directory at: staticfiles" warning before you ever run collectstatic is harmless.)

Run the tests: `python manage.py test`

## Deploy on AWS (VPC + ASG + ALB + RDS)

1. Put the values from `.env.example` into the instance environment (launch template user data or a systemd `EnvironmentFile`).
2. On each instance:
   ```bash
   pip install -r requirements-prod.txt
   python manage.py migrate        # run this from ONE instance only, not every ASG instance
   python manage.py collectstatic --noinput
   gunicorn config.wsgi:application --bind 0.0.0.0:8000 --workers 3
   ```
3. ALB target group: protocol HTTP, port 8000, **health check path `/health/`**.
   `/health/` is answered before Django checks the Host header, so the ALB's IP-based checks pass without opening `ALLOWED_HOSTS`.
4. Security groups: ALB SG allows 80/443 from the internet; instance SG allows 8000 from the ALB SG only; RDS SG allows 5432 from the instance SG only.
5. Static files are served by WhiteNoise from the instance itself, so no S3 or nginx is needed.
6. Once you add an HTTPS listener on the ALB, set `DJANGO_HTTPS=1` and add the `https://` origin to `DJANGO_CSRF_TRUSTED_ORIGINS`.

## Layout

- `config/` settings (env-driven), URLs, health-check middleware
- `tasks/` models, views, forms, tests, migrations
- `templates/`, `static/css/app.css` the whole dark theme lives in this one CSS file (colors are variables at the top)
