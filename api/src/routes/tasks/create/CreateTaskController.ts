import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { CreateTaskService } from './CreateTaskService';

export class CreateTaskController {
  async handle(req: Request, res: Response) {
    const { periodStart, periodEnd, subjectId } = req.body;
    const service = new CreateTaskService();

    try {
      const result = await service.execute(periodStart, periodEnd, subjectId);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}