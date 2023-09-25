import prismaClient from "../../../prisma";

export class ListInstitutionService {
  async execute() {
    let entities = await prismaClient.user.findMany({});

    return { entities };
  }
}
