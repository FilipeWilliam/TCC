export function handleResult(response, result) {
  if (Object.keys(result).length === 1 && result.hasOwnProperty("message")) {
    return response.status(400).json(result);
  }

  return response.json(result);
}

export function handleErrorDefault(response, error) {
  return response.status(500).json({ error: error.message });
}

export function normalizeString(string: string) {
  return string.normalize("NFD").replace(/[\u0300-\u036f]/g, "")
}

export function addZeroBeforeNumber(number: number) {
  if (number > 9) {
    return number.toString();
  } else {
    return "0" + number.toString();
  }
}

export function generateRandomString(length: number) {
  let randomString = "";
  const chars =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for (var i = 0; i < length; i++) {
    randomString += chars.charAt(Math.floor(Math.random() * chars.length));
  }

  return randomString;
}
