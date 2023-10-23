import prismaClient from "@/prisma";

export class ListRankingService {
	async execute(subjectId?: number) {
		try {
			let result: any = [];

			if (subjectId !== undefined) {
				let allUserTasks = await prismaClient.userTasks.findMany({
					where: {
						task: {
							subjectId
						}
					},
				});	

				for (let item of allUserTasks) {
					let currentUser = result.find(i => i.userId === item.userId);

					if (currentUser !== undefined) {
						currentUser.score += item.score;
					} else {
						result.push(currentUser);
					}
				}
			} else {
				result = await prismaClient.userTasks.groupBy({
					by: ['userId'],
					_sum: {
						score: true,
					},
				});	
			}
	
			return { result };
		} catch (error) {
			console.log(error);
		}
	}
}