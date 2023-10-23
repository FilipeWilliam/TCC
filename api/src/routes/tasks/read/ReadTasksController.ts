import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { ReadTasksService } from './ReadTasksService';

export class ReadTasksController {
  async handle(req: Request, res: Response) {
    const {id} = req.params;
    const service = new ReadTasksService();

    try {
      const result = await service.execute(+id);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}