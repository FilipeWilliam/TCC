import { UserTaskStatus } from "@/enums";
import prismaClient from "@/prisma";
import { UpdateUserTaskService } from "@/routes/userTasks/update/UpdateUserTaskService";
import { UpdateScoreUserTaskService } from "@/routes/userTasks/updateScore/UpdateScoreUserTaskService";

export class CreateUserTaskQuestionsService {
  async execute(questionId: number, alternative: number,  startedAt: Date, finishedAt: Date, focusOut: number, userTaskId: number) {
    try {
      if (await this.alreadyAnsweredCurrentQuestion(questionId, userTaskId)) {
        return { error: 'Pergunta já respondida.' };
      }
      
      await prismaClient.userTaskQuestions.create({
        data: {
          questionId,
          alternative,
          userTaskId,
          focusOut,
          startedAt: new Date(startedAt),
          finishedAt: new Date(finishedAt),
        }
      });

      this.verifyUserTaskIsCompleted(userTaskId);
      let message = await this.verifyIsCorrectAlternative(questionId, userTaskId, alternative);

      return { message };
    } catch (error) {
      console.log(error);
    }
  }

  private async verifyUserTaskIsCompleted(userTaskId: number) {
    let awnseredQuestionsQuantity = await prismaClient.userTaskQuestions.count({
      where: {
        userTaskId
      },
    });

    let {task: currentTask} = await prismaClient.userTasks.findUnique({
      where: {
        id: userTaskId,
      },
      select: {
        task: {
          select: {
            questions: {
              select: {
                id: true
              }
            }
          }
        }
      }
    });

    if (awnseredQuestionsQuantity === currentTask.questions.length) {
      let updateUserTaskService = new UpdateUserTaskService();
      updateUserTaskService.execute(userTaskId, UserTaskStatus.Complete);
    }
  }

  private async verifyIsCorrectAlternative(questionId: number, userTaskId: number, alternative: number) {
    let message = 'Resposta incorreta!';

    let currentQuestion = await prismaClient.questions.findFirst({
      where: {
        id: questionId
      },
      select: {
        correctAlternative: true,
      }
    });

    if (currentQuestion.correctAlternative === alternative) {
      let updateScoreUserTask = new UpdateScoreUserTaskService();
      await updateScoreUserTask.execute(userTaskId, questionId);
      message = 'Resposta correta!';
    }

    return message;
  }

  private async alreadyAnsweredCurrentQuestion(questionId: number, userTaskId: number): Promise<boolean> {
    let currentUserTaskQuestion = await prismaClient.userTaskQuestions.findFirst({
      where: {
        questionId,
        userTaskId
      }
    });

    return (currentUserTaskQuestion !== null); 
  }
}
