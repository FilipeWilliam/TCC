import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { CreateQuestionService } from './CreateQuestionService';

export class CreateQuestionController {
  async handle(req: Request, res: Response) {
    const { title, alternative1, alternative2, alternative3, alternative4, level, correctAlternative } = req.body;
    const { taskId } = req.params;
    const service = new CreateQuestionService();

    try {
      const result = await service.execute(title, alternative1, alternative2, alternative3, alternative4, +taskId, correctAlternative, level);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}