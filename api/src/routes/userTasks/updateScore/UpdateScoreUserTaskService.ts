import { QuestionLevel } from "@/enums";
import prismaClient from "../../../prisma";

export class UpdateScoreUserTaskService {
  async execute(id: number, questionId: number) {
    try {
      let points = 0;

      let {level: questionLevel} = await prismaClient.questions.findFirst({
        where: {
          id: questionId,
        },
        select: {
          level: true
        }
      });

      if (questionLevel === QuestionLevel.Easy) {
        points = 1;
      } else if (questionLevel === QuestionLevel.Medium) {
        points = 2;
      } else {
        points = 3;
      }

      let result = await prismaClient.userTasks.update({
        where: {
          id
        },
        data: {
          score: {
            increment: points
          },
        }
      });

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
