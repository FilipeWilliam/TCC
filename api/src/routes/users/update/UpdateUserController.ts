import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { UpdateUserService } from './UpdateUserService';

export class UpdateUserController {
  async handle(req: Request, res: Response) {
    const { name, email, type} = req.body;
    const {id} = req.params;

    const service = new UpdateUserService();

    try {
      const result = await service.execute(+id, name, email, type);

      return handleResult(res, result);

    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}