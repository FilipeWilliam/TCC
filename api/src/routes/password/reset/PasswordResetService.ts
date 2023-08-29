import botConversa from "../../../bot";
import prismaClient from "../../../prisma";

export class PasswordResetService {
  async execute(phone) {
    try {
      let result = await prismaClient.user.findFirst({
        where: {
          phone: {
            equals: phone
          }
        },
      });
  
      if(result === null) {
        return {message: 'Não existe um usuário com esse número.'}
      }

      if(result.botId === null) {
        return {message: 'Esse usuário não pode redefinir sua senha.'}
      }

      await botConversa.post('/subscriber/' + result.botId + '/send_flow/', {
        flow: process.env.BOT_PASSWORD_FLOW
      });
  
      return { id: result.id };
    } catch(error) {
      console.log(error);
    }
  }
}