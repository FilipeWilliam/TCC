import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { CreateUserSubjectService } from './CreateUserSubjectsService';

export class CreateUserSubjectsController {
  async handle(req: Request, res: Response) {
    const { userId, subjectId } = req.body;
    const service = new CreateUserSubjectService();

    try {
      const result = await service.execute(userId, subjectId);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}