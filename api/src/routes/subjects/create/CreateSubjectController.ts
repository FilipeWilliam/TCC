import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { CreateSubjectService } from './CreateSubjectService';

export class CreateSubjectController {
  async handle(req: Request, res: Response) {
    const { name, institutionId } = req.body;
    const service = new CreateSubjectService();

    try {
      const result = await service.execute(name, institutionId);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}