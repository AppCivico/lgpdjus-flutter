enum AuthorizationStatus {
  anonymous,
  authenticated,
}

extension Helper on AuthorizationStatus {
  get isAuthenticated {
    return this == AuthorizationStatus.authenticated;
  }
}
