import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { CreateUserTaskQuestionsService } from './CreateUserTaskQuestionsService';

export class CreateUserTaskQuestionsController {
  async handle(req: Request, res: Response) {
    const { questionId, alternative, startedAt, finishedAt, focusOut } = req.body;
    const { userTaskId } = req.params;
    const service = new CreateUserTaskQuestionsService();

    try {
      const result = await service.execute(questionId, alternative, startedAt, finishedAt, focusOut,  +userTaskId);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}