import prismaClient from "../../../prisma";

export class PasswordResetService {
  async execute(email) {
    try {
      let result = await prismaClient.user.findFirst({
        where: {
          email: {
            equals: email
          }
        },
      });
  
      if(result === null) {
        return {message: 'Não existe um usuário com esse email.'}
      }

      return { id: result.id };
    } catch(error) {
      console.log(error);
    }
  }
}