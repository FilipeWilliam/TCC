import prismaClient from "../../../prisma";

export class ListUserService {
  async execute() {
    let entities;

    entities = await prismaClient.users.findMany({});

    let usersWithoutPassword = entities.map((entity) => {
      delete entity["password"];
      return entity;
    });

    return { entities: usersWithoutPassword};
  }
}
