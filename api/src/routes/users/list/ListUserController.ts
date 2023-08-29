import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { ListUserService } from './ListUserService';

export class ListUserController {
  async handle(req: Request, res: Response) {
    const service = new ListUserService();

    try {
      const result = await service.execute();
      return handleResult(res, result);

    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}