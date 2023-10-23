import { UserTaskStatus } from "../../../enums";
import prismaClient from "../../../prisma";

export class CreateUserTaskService {
  async execute(taskId: number, userId: number) {
    try {
      let result = await prismaClient.userTasks.create({
        data: {
          score: 0,
          status: UserTaskStatus.Pending,
          taskId,
          userId,
        }
      });

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
