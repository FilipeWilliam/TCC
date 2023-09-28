import { UserTypes } from "@/enums";
import prismaClient from "../../../prisma";
import { generateRandomString } from "@/utils";

export class CreateInstitutionService {
  async execute(name: string, userName: string, userEmail: string) {
    try {
      let result = await prismaClient.institutions.create({
        data: {
          name: name,
        }
      });

      await prismaClient.users.create({
        data: {
          name: userName,
          email: userEmail,
          type: UserTypes.Admin,
          institutionId: result.id,
          password: generateRandomString(8)
        }
      })

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
