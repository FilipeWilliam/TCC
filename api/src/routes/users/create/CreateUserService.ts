import prismaClient from "@/prisma";
import { generateCryptedPassword } from "@/utils";

export class CreateUserService {
  async execute(name: string, email: string, type: number, password?: string, institutionId: number = null) {
    let cryptedPassword = generateCryptedPassword(password);

    let data: any = {
      email,
      name,
      password: cryptedPassword,
      type,
      institutionId,
    }

    try {
      let result = await prismaClient.users.create({
        data
      });
      delete result.password;

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
