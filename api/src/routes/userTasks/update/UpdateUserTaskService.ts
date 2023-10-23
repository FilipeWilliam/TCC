import prismaClient from "@/prisma";

export class UpdateUserTaskService {
  async execute(id: number, status: number) {
    try {
      let result = await prismaClient.userTasks.update({
        where: {
          id,
        },
        data: {
          status 
        }
      });

      return { result };
    } catch (error) {
      console.log(error);
    }
  }
}
