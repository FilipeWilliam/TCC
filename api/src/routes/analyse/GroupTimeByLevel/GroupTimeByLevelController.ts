import { Request, Response } from 'express';
import { GroupTimeByLevelService } from './GroupTimeByLevelService';
import { handleErrorDefault, handleResult } from '@/utils';

export class GroupTimeByLevelController {
	async handle(req: Request, res: Response) {
		const { subjectId, userId } = req.query;
    const service = new GroupTimeByLevelService();

    try {
      const result = await service.execute(subjectId, userId);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
	}
}