import prismaClient from "../../../prisma";

export class DeleteInstitutionService {
  async execute(id: number) {
    let result = await prismaClient.institution.delete(
      {
        where: {
          id
        }
      }
    );

    return { result };
  }

}