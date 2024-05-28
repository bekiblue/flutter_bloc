from rest_framework_simplejwt.tokens import UntypedToken
from rest_framework_simplejwt.exceptions import InvalidToken, TokenError
from rest_framework_simplejwt.backends import TokenBackend
from django.contrib.admin.models import User

def get_user_from_token(token):
    try:
        # This will handle decoding and validation of the token
        untyped_token = UntypedToken(token)
    except (InvalidToken, TokenError) as e:
        # Handle token validation error
        print(str(e))
        return None

    # Get the user from the decoded token data
    token_backend = TokenBackend(algorithm='HS256')
    try:
        # This will return the user associated with the token
        user = token_backend.get_user(untyped_token)
    except User.DoesNotExist:
        # Handle user not found error
        print("User does not exist.")
        return None

    return user