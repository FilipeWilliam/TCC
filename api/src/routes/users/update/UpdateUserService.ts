import prismaClient from "../../../prisma";

export class UpdateUserService {
  async execute(id, name, email, type) {
    try {
      let result = await prismaClient.user.update({
        where: {
          id,
        },
        data: {
          email,
          name,
          type,
        },
      });

      return { result };
    } catch (error) {
      return error;
    }
  }
}
