import prismaClient from "../../../prisma";

export class CreateQuestionService {
  async execute(title: string, alternative1: string, alternative2: string, alternative3: string, alternative4: string, taskId: number, correctAlternative: number, level: number) {
    try {
      let result = await prismaClient.questions.create({
        data: {
          title: title,
          taskId,
          alternative1,
          alternative2,
          alternative3,
          alternative4,
          correctAlternative,
          level
        }
      });

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
