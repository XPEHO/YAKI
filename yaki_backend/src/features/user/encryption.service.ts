import cryptoJS from "crypto-js";
import "dotenv/config";

let salt: string = "";
let iterations: number = 0;

if (process.env.CRED_HASH_PASS !== undefined && process.env.HASH_ITERATION !== undefined) {
  salt = process.env.CRED_HASH_PASS;
  iterations = parseInt(process.env.HASH_ITERATION);
} else {
  throw new TypeError("Salt undefined");
}

export default class EncryptionService {
  static hash(password: string) {
    const hashed = cryptoJS.PBKDF2(password, salt, {
      keySize: 256 / 32,
      iterations: iterations,
      hasher: cryptoJS.algo.SHA256,
    });
    return cryptoJS.enc.Hex.stringify(hashed);
  }
}
