import { pbkdf2Sync } from "crypto";
import prismaClient from "../../../prisma";

export class PasswordChangeService {
  async execute(id, password) {
    let cryptedPassword = pbkdf2Sync(password, process.env.JWT_SECRET, 1000, 64, 'sha1').toString('hex');

    let result = await prismaClient.user.update({
      where: {
        id
      },
      data: {
        password: cryptedPassword
      }
    });

    return { id: result.id };
  }
}