import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { CreateUserService } from './CreateUserService';

export class CreateUserController {
  async handle(req: Request, res: Response) {
    const { name, email, password, type, institutionId} = req.body;
    const service = new CreateUserService();

    try {
      const result = await service.execute(name, email, type, password, institutionId);

      return handleResult(res, result);

    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}