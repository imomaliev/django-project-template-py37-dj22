from .base import *


DEBUG = env("DJANGO_DEBUG", cast=bool, default=True)

INSTALLED_APPS.extend(["django_extensions", "debug_toolbar"])

MIDDLEWARE.extend(["debug_toolbar.middleware.DebugToolbarMiddleware"])


# Debug toolbar
# https://django-debug-toolbar.readthedocs.io/en/stable/index.html

DEBUG_TOOLBAR_CONFIG = {"SHOW_TOOLBAR_CALLBACK": lambda request: DEBUG}


try:
    from .local import *
except ImportError:
    pass
