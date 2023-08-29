import prismaClient from "../../../prisma";

export class DeleteUserService {
  async execute(id: number) {
    let result = await prismaClient.user.delete(
      {
        where: {
          id
        }
      }
    );

    delete result.password;

    return { result };
  }

}