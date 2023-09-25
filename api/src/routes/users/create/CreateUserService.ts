import { pbkdf2Sync } from "crypto";
import prismaClient from "../../../prisma";
import { generateRandomString } from "../../../utils";

export class CreateUserService {
  async execute(name, email, password, type) {
    let cryptedPassword;

    if (!password) {
      cryptedPassword = pbkdf2Sync(
        generateRandomString(8),
        process.env.JWT_SECRET,
        1000,
        64,
        "sha1"
      ).toString("hex");
    } else {
      cryptedPassword = pbkdf2Sync(
        password,
        process.env.JWT_SECRET,
        1000,
        64,
        "sha1"
      ).toString("hex");
    }

    let data: any = {
      email,
      name,
      password: cryptedPassword,
      type,
    }

    try {
      let result = await prismaClient.user.create({
        data
      });
      delete result.password;

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
