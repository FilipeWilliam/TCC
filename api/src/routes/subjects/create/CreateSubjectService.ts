import prismaClient from "../../../prisma";

export class CreateSubjectService {
  async execute(name: string, institutionId: number) {
    try {
      let result = await prismaClient.subjects.create({
        data: {
          name,
          institutionId
        }
      });

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
