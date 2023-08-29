import { UserTypes } from "../enums";
import prismaClient from "../prisma";

//Services
import { CreateUserService } from "../routes/users/create/CreateUserService";

export async function verifyNeedDBInit() {
  let hasSystemUser = await prismaClient.user.findFirst({
    where: {
      type: UserTypes.System,
    },
  });

  if (!hasSystemUser) {
    await createDefaultUsers();

    return true;
  } else {
    return false;
  }
}

export async function createDefaultUsers() {
  try {
    let service = new CreateUserService();
    await service.execute(
      "System",
      "dev@ifc.com",
      "devifc",
      UserTypes.System,
    );
    await service.execute(
      "Estudante",
      "estudante@ifc.com",
      "estudanteifc",
      UserTypes.Student,
    );
  } catch (error) {
    console.log(error);
  }
}