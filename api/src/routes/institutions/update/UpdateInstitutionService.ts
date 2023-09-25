import prismaClient from "../../../prisma";

export class UpdateInstitutionService {
  async execute(id, name) {
    try {
      let result = await prismaClient.institution.update({
        where: {
          id,
        },
        data: {
          name,
        },
      });

      return { result };
    } catch (error) {
      return error;
    }
  }
}
