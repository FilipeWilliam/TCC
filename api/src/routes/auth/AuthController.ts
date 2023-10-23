import { Request, Response } from 'express';
import { AuthService } from './AuthService';
import { handleErrorDefault, handleResult } from '@/utils';

class AuthController {
  async handle(req: Request, res: Response) {
    const { email, password } = req.body;
    const service = new AuthService();

    try {
      const result = await service.execute(email, password);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }

  }
}

export { AuthController };