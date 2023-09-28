import prismaClient from "../../../prisma";

export class DeleteInstitutionService {
  async execute(id: number) {
    let result = await prismaClient.institutions.delete(
      {
        where: {
          id
        }
      }
    );

    return { result };
  }

}