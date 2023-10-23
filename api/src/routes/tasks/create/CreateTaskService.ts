import { UserTypes } from "../../../enums";
import prismaClient from "@/prisma";
import { CreateUserTaskService } from "@/routes/userTasks/create/CreateUserTaskService";

export class CreateTaskService {
  async execute(periodStart: string, periodEnd: string, subjectId: number) {
    try {
      let result = await prismaClient.tasks.create({
        data: {
          periodStart: new Date(periodStart + ' 00:00:00'),
          periodEnd: new Date(periodEnd + ' 23:59:59'),
          subjectId
        }
      });

      let allCurrentSubjectStudents = await prismaClient.userSubjects.findMany({
        where: {
          id: subjectId,
          user: {
            type: UserTypes.Student
          },
        },
        select: {
          userId: true,
        }
      });
      
      if (allCurrentSubjectStudents.length > 0) {
        let userTaksService = new CreateUserTaskService();

        for (let userSubject of allCurrentSubjectStudents) {
          await userTaksService.execute(result.id, userSubject.userId);
        }
      }

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
