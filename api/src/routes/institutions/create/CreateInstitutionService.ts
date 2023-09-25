import prismaClient from "../../../prisma";

export class CreateInstitutionService {
  async execute(name: string) {
    try {
      let result = await prismaClient.institution.create({
        data: {
          name: name,
        }
      });

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
