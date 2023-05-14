export function getEnvVariable(name: string): string | undefined {
  return window[name] || process.env[name];
}

export const BASE_API_URL = getEnvVariable("NX_BASE_API_URL");
export const AUTH_GITHUB_ENABLED = getEnvVariable("NX_AUTH_GITHUB_ENABLED");
export const AUTH_GOOGLE_ENABLED = getEnvVariable("NX_AUTH_GOOGLE_ENABLED");