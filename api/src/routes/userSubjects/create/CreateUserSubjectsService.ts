import prismaClient from "@/prisma";

export class CreateUserSubjectService {
  async execute(userId: number, subjectId: number) {
    try {
      let result = await prismaClient.userSubjects.create({
        data: {
          userId,
          subjectId
        }
      });

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
