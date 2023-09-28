import { UserTypes } from "../enums";
import prismaClient from "../prisma";

//Services
import { CreateUserService } from "../routes/users/create/CreateUserService";

export async function verifyNeedDBInit(): Promise<void> {
  let hasSystemUser = await prismaClient.users.findFirst({
    where: {
      type: UserTypes.System,
    },
  });

  if (!hasSystemUser) {
    await createDefaultUsers();
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
      "SystemAdmin",
      "admin@ifc.com",
      "adminifc",
      UserTypes.SystemAdmin,
    );
  } catch (error) {
    console.log(error);
  }
}