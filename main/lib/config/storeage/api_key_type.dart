enum ApiKeyType { wasteManagementKey, googleApiKey}

String getApiKeyString(ApiKeyType keyType) {
  switch (keyType) {
    case ApiKeyType.wasteManagementKey:
      return 'api_wastemanagement_key';
    case ApiKeyType.googleApiKey:
      return 'googlAapiKey';
    default:
      return '';
  }
}
