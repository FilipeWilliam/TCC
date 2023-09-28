import prismaClient from "@/prisma";

export class ListInstitutionService {
  async execute() {
    let entities = await prismaClient.users.findMany({});

    return { entities };
  }
}
