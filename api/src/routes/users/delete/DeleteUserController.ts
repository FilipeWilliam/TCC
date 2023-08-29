import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { DeleteUserService } from './DeleteUserService';

export class DeleteUserController {
  async handle(req: Request, res: Response) {
    const { id } = req.params;
    const service = new DeleteUserService();

    try {
      const result = await service.execute(+id);
      return handleResult(res, result);

    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}