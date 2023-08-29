import { Request, Response } from 'express';
import { AuthService } from './AuthService';

class AuthController {
  async handle(req: Request, res: Response) {
    const { email, password } = req.body;
    const service = new AuthService();

    try {
      const result = await service.execute(email, password);

      if (result.message) {
        return res.status(400).json(result);
      }

      return res.json(result);

    } catch (err) {
      return res.json({ error: err.message });
    }

  }
}

export { AuthController };