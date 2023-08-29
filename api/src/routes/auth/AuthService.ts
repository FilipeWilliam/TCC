import prismaClient from "../../prisma";
import { pbkdf2Sync } from "crypto";
import { sign } from 'jsonwebtoken';

class AuthService {
  async execute(email: string, currentPassword: string) {
    let user = await prismaClient.user.findFirst({
      where: {
        email,
      },
    });

    if (!user) {
      return { message: 'Usuário não encontrado' };
    }

    let cryptedPassword = pbkdf2Sync(currentPassword, process.env.JWT_SECRET, 1000, 64, 'sha1').toString('hex');

    if (user.password !== cryptedPassword) {
      return { message: 'Senha incorreta' };
    }

    const token = sign(
      {
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          type: user.type,
        }
      },
      process.env.JWT_SECRET,
      {
        subject: user.id.toString(),
        expiresIn: '1d'
      }
    );

    const { password, ...data } = user;

    return { token, data };
  }
}

export { AuthService };