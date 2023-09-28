import prismaClient from "../../../prisma";

export class DeleteUserService {
  async execute(id: number) {
    let result = await prismaClient.users.delete(
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