import { useState } from "react";
import "./App.css";
import { isEnvBrowser } from "./utils/misc";
import {
	Badge,
	Group,
	Transition,
	Text,
	Button,
	Divider,
	SimpleGrid,
	Title,
	Modal,
	ScrollArea,
} from "@mantine/core";
import { useNuiEvent } from "./hooks/useNuiEvent";
import {
	IconPlayerPlay,
	IconPlus,
	IconTrash,
	IconUsersGroup,
} from "@tabler/icons-react";
import InfoCard from "./components/InfoCard";
import { fetchNui } from "./utils/fetchNui";
import { useDisclosure } from "@mantine/hooks";
import CreateCharacterModal from "./components/CreateCharacterModal";
import { modals } from "@mantine/modals";

type CharacterMetadata = Array<{ key: string; value: string }>;

interface Character {
	citizenid: string;
	name: string;
	metadata: CharacterMetadata;
	cid: number;
}

const DEBUG_CHARACTERS: Character[] = [
	{
		citizenid: "Whatever",
		name: "John Doe",
		metadata: [
			{
				key: "job",
				value: "Police",
			},
			{
				key: "nationality",
				value: "Denmark",
			},
			{
				key: "bank",
				value: "100.0000",
			},
			{
				key: "cash",
				value: "430.000",
			},
			{
				key: "birthdate",
				value: "12-10-1899",
			},
			{
				key: "gender",
				value: "Male",
			},
		],
		cid: 1,
	},
	{
		citizenid: "Whatever12",
		name: "Jenna Doe",
		metadata: [
			{
				key: "job",
				value: "Police",
			},
			{
				key: "nationality",
				value: "Denmark",
			},
			{
				key: "bank",
				value: "100.0000",
			},
			{
				key: "cash",
				value: "430.000",
			},
			{
				key: "birthdate",
				value: "12-10-1899",
			},
			{
				key: "gender",
				value: "Male",
			},
		],
		cid: 2,
	},
	{
		citizenid: "Hallo",
		name: "Jake long",
		metadata: [
			{
				key: "job",
				value: "Police",
			},
			{
				key: "nationality",
				value: "Denmark",
			},
			{
				key: "bank",
				value: "100.0000",
			},
			{
				key: "cash",
				value: "430.000",
			},
			{
				key: "birthdate",
				value: "12-10-1899",
			},
			{
				key: "gender",
				value: "Male",
			},
		],
		cid: 3,
	},
];

function App() {
	const [visible, setVisible] = useState(isEnvBrowser() ? true : false);
	const [characters, setCharacters] = useState<Character[]>(
		isEnvBrowser() ? DEBUG_CHARACTERS : []
	);
	const [isSelected, setIsSelected] = useState(-1);
	const [createCharacterId, setCreateCharacterId] = useState(-1);
	const [opened, { open, close }] = useDisclosure(false);
	const [allowedCharacters, setAllowedCharacters] = useState(
		isEnvBrowser() ? 3 : 0
	);

	useNuiEvent<{ characters: Character[]; allowedCharacters: number }>(
		"showMultiChar",
		(data) => {
			setCharacters(data.characters);
			setAllowedCharacters(data.allowedCharacters);
			setVisible(true);
		}
	);

	const HandleSelect = async (key: number, citizenid: string) => {
		await fetchNui<number>(
			"selectCharacter",
			{ citizenid: citizenid },
			{ data: 1 }
		);
		setIsSelected(key);
	};

	const HandlePlay = async (citizenid: string) => {
		setVisible(false);
		setCharacters([]);
		setIsSelected(-1);
		await fetchNui<number>(
			"playCharacter",
			{ citizenid: citizenid },
			{ data: 1 }
		);
	};

	const HandleDelete = async (citizenid: string) => {
		setVisible(false);
		setCharacters([]);
		setIsSelected(-1);
		await fetchNui<number>(
			"deleteCharacter",
			{ citizenid: citizenid },
			{ data: 1 }
		);
	};

	const HandleCreate = () => {
		close();
		setVisible(false);
		setCharacters([]);
		setIsSelected(-1);
	};

	const openDeleteModal = (citizenid: string) =>
		modals.openConfirmModal({
			title: "Delete your character",
			centered: true,
			children: (
				<Text size='sm' c="rgba(255, 255, 255, 0.8)">
					Are you sure you want to delete your character? This action cannot be undone.
				</Text>
			),
			labels: { confirm: "Delete character", cancel: "Cancel" },
			confirmProps: { 
				color: "red",
				style: {
					background: 'rgba(239, 68, 68, 0.15)',
					backdropFilter: 'blur(10px)',
					WebkitBackdropFilter: 'blur(10px)',
					border: '1px solid rgba(239, 68, 68, 0.3)',
					color: 'rgba(255, 255, 255, 0.95)',
					fontWeight: 500,
				}
			},
			styles: {
				content: {
					background: 'rgba(20, 20, 25, 0.95)',
					backdropFilter: 'blur(30px) saturate(180%)',
					WebkitBackdropFilter: 'blur(30px) saturate(180%)',
					border: '1px solid rgba(255, 255, 255, 0.18)',
					borderRadius: '20px',
					boxShadow: '0 8px 32px 0 rgba(0, 0, 0, 0.5)',
				},
				header: {
					background: 'rgba(255, 255, 255, 0.05)',
					borderBottom: '1px solid rgba(255, 255, 255, 0.1)',
				},
				title: {
					color: 'white',
					fontWeight: 600,
				},
				close: {
					color: 'rgba(255, 255, 255, 0.7)',
				},
			},
			onCancel: () => console.log("Cancel"),
			onConfirm: () => HandleDelete(citizenid),
		});

	return (
		<>
			<Modal
				opened={opened}
				onClose={close}
				title={"Create Character " + (createCharacterId + 1)}
				centered
				styles={{
					content: {
						background: 'rgba(20, 20, 25, 0.95)',
						backdropFilter: 'blur(30px) saturate(180%)',
						WebkitBackdropFilter: 'blur(30px) saturate(180%)',
						border: '1px solid rgba(255, 255, 255, 0.18)',
						borderRadius: '20px',
						boxShadow: '0 8px 32px 0 rgba(0, 0, 0, 0.5)',
					},
					header: {
						background: 'rgba(255, 255, 255, 0.05)',
						borderBottom: '1px solid rgba(255, 255, 255, 0.1)',
					},
					title: {
						color: 'white',
						fontWeight: 600,
					},
					close: {
						color: 'rgba(255, 255, 255, 0.7)',
					},
				}}
			>
				<CreateCharacterModal
					id={createCharacterId + 1}
					handleCreate={HandleCreate}
				/>
			</Modal>

			<div className={`app-container`}>
				<div className='container'>
					{visible && (
						<div className='character-selector-top'>
							<IconUsersGroup size={50} style={{ color: 'rgba(120, 119, 198, 0.9)', filter: 'drop-shadow(0 0 10px rgba(120, 119, 198, 0.5))' }} />
							<Title order={2} fz={36} c={"white"} fw={700} style={{ 
								background: 'linear-gradient(135deg, rgba(120, 119, 198, 1) 0%, rgba(255, 119, 198, 1) 100%)',
								WebkitBackgroundClip: 'text',
								WebkitTextFillColor: 'transparent',
								backgroundClip: 'text',
								textShadow: '0 0 30px rgba(120, 119, 198, 0.3)'
							}}>
								Welcome to One Life Roleplay
							</Title>
							<Text fw={400} fz={16} c="rgba(255, 255, 255, 0.8)">
								Select the character you want to play
							</Text>
						</div>
					)}

					<Transition transition='slide-up' mounted={visible}>
						{(style: React.CSSProperties) => (
							<ScrollArea style={{ ...style }} w={1650}>
								<div className='multichar'>
									{[...Array(allowedCharacters)].map((_, index) => {
										const character = characters[index];
										return character ? (
											<div className='character-card'>
												<Group justify='space-between' style={{ marginBottom: '5px' }}>
													<Text fw={600} fz={20} c="white" style={{ 
														textShadow: '0 2px 10px rgba(0, 0, 0, 0.3)'
													}}>
														{character.name}
													</Text>
													<Badge
														variant='light'
														radius='md'
														style={{
															background: 'rgba(255, 255, 255, 0.1)',
															backdropFilter: 'blur(10px)',
															WebkitBackdropFilter: 'blur(10px)',
															border: '1px solid rgba(255, 255, 255, 0.2)',
															color: 'rgba(255, 255, 255, 0.9)',
															fontSize: '11px',
															fontWeight: 500
														}}
													>
														{character.citizenid}
													</Badge>
												</Group>

												<div
													className={
														isSelected === character.cid ? "show" : "hide"
													}
												>
													<SimpleGrid cols={2} spacing={3}>
														{character.metadata &&
															character.metadata.length > 0 &&
															character.metadata.map((metadata: { key: string; value: string }) => (
																<InfoCard
																	key={metadata.key}
																	icon={metadata.key}
																	label={metadata.value}
																/>
															))}
													</SimpleGrid>

													<Divider 
														color='rgba(255, 255, 255, 0.1)' 
														size="sm"
														style={{ margin: '5px 0' }}
													/>

													<div className='character-card-actions'>
														<Button
															color='green'
															variant='light'
															fullWidth
															leftSection={<IconPlayerPlay size={16} />}
															h={38}
															radius="md"
															style={{
																background: 'rgba(34, 197, 94, 0.15)',
																backdropFilter: 'blur(10px)',
																WebkitBackdropFilter: 'blur(10px)',
																border: '1px solid rgba(34, 197, 94, 0.3)',
																color: 'rgba(255, 255, 255, 0.95)',
																fontWeight: 500,
																transition: 'all 0.2s ease',
															}}
															onMouseEnter={(e: React.MouseEvent<HTMLButtonElement>) => {
																e.currentTarget.style.background = 'rgba(34, 197, 94, 0.25)';
																e.currentTarget.style.borderColor = 'rgba(34, 197, 94, 0.5)';
																e.currentTarget.style.transform = 'translateY(-2px)';
															}}
															onMouseLeave={(e: React.MouseEvent<HTMLButtonElement>) => {
																e.currentTarget.style.background = 'rgba(34, 197, 94, 0.15)';
																e.currentTarget.style.borderColor = 'rgba(34, 197, 94, 0.3)';
																e.currentTarget.style.transform = 'translateY(0)';
															}}
															onClick={() => {
																HandlePlay(character.citizenid);
															}}
														>
															Play
														</Button>

														<Button
															color='red'
															variant='light'
															fullWidth
															leftSection={<IconTrash size={16} />}
															h={38}
															radius="md"
															style={{
																background: 'rgba(239, 68, 68, 0.15)',
																backdropFilter: 'blur(10px)',
																WebkitBackdropFilter: 'blur(10px)',
																border: '1px solid rgba(239, 68, 68, 0.3)',
																color: 'rgba(255, 255, 255, 0.95)',
																fontWeight: 500,
																transition: 'all 0.2s ease',
															}}
															onMouseEnter={(e: React.MouseEvent<HTMLButtonElement>) => {
																e.currentTarget.style.background = 'rgba(239, 68, 68, 0.25)';
																e.currentTarget.style.borderColor = 'rgba(239, 68, 68, 0.5)';
																e.currentTarget.style.transform = 'translateY(-2px)';
															}}
															onMouseLeave={(e: React.MouseEvent<HTMLButtonElement>) => {
																e.currentTarget.style.background = 'rgba(239, 68, 68, 0.15)';
																e.currentTarget.style.borderColor = 'rgba(239, 68, 68, 0.3)';
																e.currentTarget.style.transform = 'translateY(0)';
															}}
															onClick={() => {
																openDeleteModal(character.citizenid);
															}}
														>
															Delete
														</Button>
													</div>
												</div>

												<div
													className={
														isSelected === character.cid ? "hide" : "show"
													}
												>
													<Button
														color='blue'
														variant='light'
														fullWidth
														h={38}
														radius="md"
														style={{
															background: 'rgba(59, 130, 246, 0.15)',
															backdropFilter: 'blur(10px)',
															WebkitBackdropFilter: 'blur(10px)',
															border: '1px solid rgba(59, 130, 246, 0.3)',
															color: 'rgba(255, 255, 255, 0.95)',
															fontWeight: 500,
															transition: 'all 0.2s ease',
														}}
														onMouseEnter={(e: React.MouseEvent<HTMLButtonElement>) => {
															e.currentTarget.style.background = 'rgba(59, 130, 246, 0.25)';
															e.currentTarget.style.borderColor = 'rgba(59, 130, 246, 0.5)';
															e.currentTarget.style.transform = 'translateY(-2px)';
														}}
														onMouseLeave={(e: React.MouseEvent<HTMLButtonElement>) => {
															e.currentTarget.style.background = 'rgba(59, 130, 246, 0.15)';
															e.currentTarget.style.borderColor = 'rgba(59, 130, 246, 0.3)';
															e.currentTarget.style.transform = 'translateY(0)';
														}}
														onClick={() => {
															HandleSelect(character.cid, character.citizenid);
														}}
													>
														Select
													</Button>
												</div>
											</div>
										) : (
											<div
												className='character-card create-card'
												key={`create-${index}`}
											>
												<Button
													color='blue'
													variant='light'
													fullWidth
													leftSection={<IconPlus size={28} />}
													h={50}
													radius="md"
													style={{
														background: 'rgba(120, 119, 198, 0.15)',
														backdropFilter: 'blur(10px)',
														WebkitBackdropFilter: 'blur(10px)',
														border: '1px solid rgba(120, 119, 198, 0.3)',
														color: 'rgba(255, 255, 255, 0.95)',
														fontWeight: 600,
														fontSize: '16px',
														transition: 'all 0.3s ease',
													}}
													onMouseEnter={(e: React.MouseEvent<HTMLButtonElement>) => {
														e.currentTarget.style.background = 'rgba(120, 119, 198, 0.25)';
														e.currentTarget.style.borderColor = 'rgba(120, 119, 198, 0.5)';
														e.currentTarget.style.transform = 'scale(1.02)';
													}}
													onMouseLeave={(e: React.MouseEvent<HTMLButtonElement>) => {
														e.currentTarget.style.background = 'rgba(120, 119, 198, 0.15)';
														e.currentTarget.style.borderColor = 'rgba(120, 119, 198, 0.3)';
														e.currentTarget.style.transform = 'scale(1)';
													}}
													onClick={() => {
														open();
														setCreateCharacterId(index);
													}}
												>
													Create New Character
												</Button>
											</div>
										);
									})}
								</div>
							</ScrollArea>
						)}
					</Transition>
				</div>
			</div>
		</>
	);
}

export default App;
